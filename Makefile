all: index.js

%.js: %.ls
	node_modules/.bin/lsc -pc $(LS_OPTS) "$<" > "$@"

.PHONY: test
test: all
	node_modules/.bin/faucet test.js
	node_modules/.bin/uglifyjs test.js  --mangle | node | node_modules/.bin/faucet

test-browser: all
	node_modules/.bin/browserify test.js | node_modules/.bin/testling | node_modules/.bin/faucet