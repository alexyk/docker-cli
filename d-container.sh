#!/bin/bash

debug=0
cmd=$(basename $0)

echo

if [ "$1" == 'test' ]; then
	echo "Running tests ..."
	$cmd debug
	$cmd debug -h
	$cmd debug start
	$cmd debug term
	$cmd debug list
	$cmd debug attach
	$cmd debug exec
	$cmd debug logs
	$cmd debug something else
	echo "Running tests done."
	echo
	exit $?
elif [ "$1" == 'debug' ]; then
	shift
	debug=1
fi



# E x e c u t e

((debug)) && 	echo "Arguments: $@"

case $1 in

  # get help
	'-h' | 'help' | '-help' | '--help' | '?' | '/?' )
		echo "Usage summary:"
		echo "  $cmd [term|list|attach|exec|logs|help] [container] [...args]"
		echo
		echo "Examples:"
		echo "  $cmd -h|-help|--help|?|/?		print this help"
		echo "  $cmd 				list all containers"
		echo "  $cmd ls|list arg1 arg2 ... 		list with additonal arguments"
		echo "  $cmd start <container>		start a paused or stopped container"
		echo "  $cmd stop <container>		stop/paused a container"
		echo "  $cmd term|bash|sh|zsh <container>	start a bash/sh/zsh session in the container"
		echo "  $cmd attach arg1 arg2 ... 		attach to a container"
		echo "  $cmd exec arg1 arg2 ...		execute on a container"
		echo "  $cmd logs|log|history ... 		print container history/logs"
		echo "  $cmd ... 				any other command"
		echo
		echo "In addition, to run tests (debug mode run):"
		echo "  $cmd test"
		echo
		exit 1
		;;

	'start' ) # start a paused/stopped container
		if ((debug)); then
			echo "DEBUG: Executing START"
		else
			docker start -i $2
		fi
		;;

	# start a terminal (bash)
	'term' | 'terminal' | 'bash' | 'cmd' )
		if ((debug)); then
			echo "DEBUG: Executing TERM"
		else
			docker exec -it $2 bash
		fi
		;;

	'sh' ) # start a terminal (sh)
		if ((debug)); then
			echo "DEBUG: Executing SH"
		else
			docker exec -it $2 sh
		fi
		;;

	
	'zsh' ) # start a terminal (zsh)
		if ((debug)); then
			echo "DEBUG: Executing ZSH"
		else
			docker exec -it $2 zsh
		fi
		;;

	'list' | 'ls' ) # list
		if ((debug)); then
			echo "DEBUG: Executing LIST"
		else
			docker container ls $2 $3 $4 $5 $6 $7
		fi
		;;
	
	'attach' ) # attach to container
		if ((debug)); then
			echo "DEBUG: Executing ATTACH"
		else
			docker container attach $2 $3 $4 $5 $6 $7
		fi
		;;
	
	'exec' ) # execute on a container
		if ((debug)); then
			echo "DEBUG: Executing EXEC"
		else
			docker container exec $2 $3 $4 $5 $6 $7
		fi
		;;
	
	'logs' | 'log' | 'history' ) # see log
		if ((debug)); then
			echo "DEBUG: Executing LOGS"
		else
			docker container logs $2 $3 $4 $5 $6 $7
		fi
		;;
	
	'' ) # list all
		if ((debug)); then
			echo "DEBUG: Executing LIST-ALL"
		else
			docker container ls -a
		fi
		;;

	* ) # generic command
		if ((debug)); then
			echo "DEBUG: Executing CMD (generic command): $@"
		else
			docker container "$@"
		fi
		;;

esac

if ((debug)); then
	echo "DEBUG: Done."
else
	echo
fi
echo