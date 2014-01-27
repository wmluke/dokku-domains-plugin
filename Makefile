.PHONY: all test clean

test:
	test/commands_test.sh
	test/post-deploy_test.sh
