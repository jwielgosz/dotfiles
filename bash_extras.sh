
#===========================================================================
# Global
alias b='. ~/Dropbox/bin/bash_extras.sh'
alias bbb='bb ~/Dropbox/bin/bash_extras.sh'
alias sw='s ~/Dropbox/bin/bash_extras.sh'

alias topme='top -u ${USER}'
alias cx='chmod +x'

cdd() {
	cd `dirname $1`
}

echorun() {
	echo "$@"
  	$@
}

ifnz() {
	if [ $1 -ne 0 ] ; then 
		shift
		eval "$*"
	fi
}

ifz() {
	if [ $1 -eq 0 ] ; then 
		shift
		eval "$*"
	fi
}

h() {
	ifz $# history
	ifnz $# "history | grep $@"
}

abs() {
	for f in $@ ; do 
	find `pwd` -name "${f}"
	done
}

checkpath() {
	origpath=$1
	basepath=$origpath
	while [ ! -d $basepath ] ; do 
		parent=$(dirname $basepath)
		if [ "$parent" == "$basepath" ] ; then
			break
		fi
		basepath=$parent	
	done

	baselen=${#basepath}
	echo Matched: $basepath
	echo Not found: ${origpath:baselen}
}

findnewest() {
	find . $@ -print0 | xargs -0 stat -f "%m %N" |
sort -rn
}

get_pw () {
  security 2>&1 >/dev/null find-internet-password -gs $1 \
  |ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

sshp () {
  SSHPASS=`get_pw $1` sshpass -e ssh -Y $1
}



#==========================================================
# git
# from http://gitimmersion.com/lab_11.html

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gm='git commit -m'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '


#===========================================================================
# Mac

export PATH=${PATH}:~/bin:~/Dropbox/bin

if [ $(uname) == "Darwin" ] ; then

	s() {
		SUBLIME=/Applications/Sublime\ Text.app
		if [ -e "${SUBLIME}" ] ; then
		open -a "${SUBLIME}" $@
		else
		echo "No Sublime Text."
		fi
	}

	tw() {
		TW=/Applications/TextWrangler.app
		if [ -e ${TW} ] ; then
		open -a ${TW} $@
		else
		echo "No TextWrangler."
		fi
	}

	bb() {
		BB=/Applications/BBEdit.app
		if [ -e ${BB} ] ; then
		open -a ${BB} $@
		else
		echo "No BBEdit."
		fi
	}

	

fi

#===========================================================================
# Stanford / PanLab

alias panlab='ssh -XY wielgosz@sni-vcs-williams2.stanford.edu'




#===========================================================================
# Waisman lab
alias mat='xterm -iconic -e matlab &'

keck () {
	sshp ${1}.keck.waisman.wisc.edu
	}

#Submit condor jobs
alias guero='keck guero'

#Testing only
alias cayenne='keck cayenne'
alias poblano='keck poblano'
alias sandia='keck sandia'
alias caloro='keck caloro'

kecksync () {
 UNISONLOCALHOSTNAME=`hostname` ~/Dropbox/bin/sshpc guero.keck.waisman.wisc.edu ~/Dropbox/bin/unison $1 
}

#===========================================================================
# MATLAB


#===========================================================================
# Veterans Wellness study

vw() {
	cd /study/vw/$@
}

alias vwa='cd /study/vw/analysis; pwd'
alias vwd='cd /study/vw/data; pwd'
alias vwf='cd /study/vw/data/fmri/processed/T2; pwd'
alias vwr='cd /study/vw/analysis/psychophyz/resp; pwd'

# current
alias vwp='cd /study/vw/analysis/fmri/preprocess'


mailme() {
	echo ${2:-Job complete} | mail -s "${1:-Job complete}" wielgosz@wisc.edu
}

vwc_log() {
  vwc_latest=$( ls -t . | grep vw_condor_log | head -1 2> /dev/null ) 
  if [ -n "$vwc_latest" ] ; then
	echo "Tailing output for: $vwc_latest"
	tail -f ${newlog}/*
  else
  	echo "No vw_condor logs found."
  fi
  	
}

vwc_clean() { #remove logs made by vw_condor.sh
  echorun "rm -rf vw_condor_log.${1}*"
}



echo =
