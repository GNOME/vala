#!/bin/sh

DEBUG_FLAGS=""
#DEBUG_FLAGS="$DEBUG_FLAGS -D DEBUG"
#DEBUG_FLAGS="$DEBUG_FLAGS -D HARD_DEBUG"
#DEBUG_FLAGS="$DEBUG_FLAGS -D VERY_HARD_DEBUG"

COMMAND="./testparser testcomment.test"
COMMAND="gdb -ex run -ex bt -ex finish -ex quit --args $COMMAND"

valac -C $DEBUG_FLAGS -g -o testparser --pkg vala-1.0 \
	parser/commentscanner.vala \
	parser/documentationfactory.vala \
	parser/documentationparser.vala \
	parser/manyrule.vala \
	parser/oneofrule.vala \
	parser/parser.vala \
	parser/parsercallback.vala \
	parser/rule.vala \
	parser/scanner.vala \
	parser/sequencerule.vala \
	parser/stubrule.vala \
	parser/token.vala \
	parser/wikiscanner.vala \
	documentation/errorreporter.vala \
	settings.vala \
	testparser.vala \
&& valac $DEBUG_FLAGS -g -o testparser --pkg vala-1.0 \
	parser/commentscanner.vala \
	parser/documentationfactory.vala \
	parser/documentationparser.vala \
	parser/manyrule.vala \
	parser/oneofrule.vala \
	parser/parser.vala \
	parser/parsercallback.vala \
	parser/rule.vala \
	parser/scanner.vala \
	parser/sequencerule.vala \
	parser/stubrule.vala \
	parser/token.vala \
	parser/wikiscanner.vala \
	documentation/errorreporter.vala \
	settings.vala \
	testparser.vala \
&& $COMMAND
