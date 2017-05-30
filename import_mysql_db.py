#!/usr/bin/env python
import subprocess
import argparse
import getpass
import oursql

def parse_arguments():
	parser = argparse.ArgumentParser(description="Imports a database. It deletes all the tables before running an import file.")
	parser.add_argument("--verbose", "-v",
		help="Log every little thing.",
		action="store_true"
	)
	parser.add_argument("database",
		help="Name of the database.",
		type=str
	)
	parser.add_argument("dump",
		help="Path to the dump file.",
		type=argparse.FileType('r')
	)
	return parser.parse_args()

def echo(s):
	if (args.verbose):
		print s

def connect(database, user, password):
	return oursql.connect(host='localhost', user=user, passwd=password, db=database).cursor()

def empty_database(cursor):
	cursor.execute("SHOW TABLES")
	for table in cursor.fetchall():
		cursor.execute("DROP TABLE %s" % table)

def import_dump(database, user, password, dump):
	subprocess.call("mysql -u%s -p%s %s" % (user, password, database), stdin=dump, shell=True)

try:
	args = parse_arguments()
	user = 'root'
	password = getpass.getpass("Enter the password for user '%s':\n" % user)

	cursor = connect(args.database, user, password)
	empty_database(cursor)
	import_dump(args.database, user, password, args.dump)
except ValueError as e:
	print e.message
