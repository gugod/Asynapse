run-jifty:
	@( cd AsynapseFileTester; bin/jifty server --port 3001 )

test-jifty:
	@( sleep 2; open http://localhost:3001/static/run/index.html ) &
	@echo Please open http://localhost:3001/static/run/index.html
	@echo if it is not showing automatically.
	@( cd AsynapseFileTester; bin/jifty server --port 3001 )

run-catalyst:
	@( cd AsynapseCatalystTester; script/*_server.pl --port 3001 )

test-catalyst:
	@( sleep 2; open http://localhost:3001/static/run/index.html ) &
	@echo Please open http://localhost:3001/static/run/index.html
	@echo if it is not showing automatically.
	@( cd AsynapseCatalystTester; script/*_server.pl --port 3001 )

