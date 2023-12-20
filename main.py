from Source.db_functions.db_functions import MyDatabase
import Source.logger as log

main_logger = log.app_logger('Main')

"""
Run this file to perform actions on a database.
"""

if __name__ == '__main__':
    with MyDatabase() as db:
        print('Working with a database. For a list of commands, type "help". \n')

        db_help = ("To test a connection with a database: test \n"
                   "To create a table: create \n"
                   "To get the list of tables in a database: check \n"
                   "To copy data from a CSV file to a specified table: copy \n"
                   "To write a custom SQL statement: sql \n"
                   "To get a movie or a tv show recommendation based on a genre: rec \n"
                   "To quit: exit")

        while True:
            user_input = input('Enter a command: ')
            user_input = user_input.strip()
            user_input = user_input.lower()

            if user_input.startswith('test'):
                try:
                    db.test_connection()
                except Exception as err:
                    main_logger.exception('An error occurred: "%s"\n', err)
                    continue

            elif user_input.startswith('create'):
                try:
                    db.create_table()
                except Exception as err:
                    main_logger.exception('An error occurred: "%s"\n', err)
                    continue

            elif user_input.startswith('check'):
                try:
                    db.check_if_created()
                except Exception as err:
                    main_logger.exception('An error occurred: "%s"\n', err)
                    continue

            elif user_input.startswith('copy'):
                try:
                    db.copy_to_table()
                except Exception as err:
                    main_logger.exception('An error occurred: "%s"\n', err)
                    continue

            elif user_input.startswith('sql'):
                try:
                    db.my_custom_sql()
                except (Exception, TypeError) as err:
                    main_logger.exception('An error occurred: "%s"\n', err)
                    continue

            elif user_input.startswith('rec'):
                try:
                    db.get_recommendation()
                except (Exception, TypeError) as err:
                    main_logger.exception('An error occurred: "%s"\n', err)
                    continue

            elif user_input.startswith('help'):
                print(db_help, '\n')
                continue

            elif user_input.startswith('exit'):
                break

            else:
                main_logger.exception('Unknown command. For the list of commands type "help" \n')
                continue


