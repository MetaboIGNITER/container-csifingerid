#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  sirius.sh start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

# Add default JVM options here. You can also use JAVA_OPTS and SIRIUS_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS='"-Xms1G" "-XX:MaxRAMPercentage=85" "--illegal-access=permit" "--add-opens=java.base/java.lang=ALL-UNNAMED" "--add-opens=java.base/java.net=ALL-UNNAMED" "-javaagent:$APP_HOME/lib/app/agents-4.4.8.jar"'

# Add full lib dir to classpath
CLASSPATH="$APP_HOME/lib/app/*"

# Determine the Java command to use to start the JVM.
JAVACMD="$APP_HOME/lib/runtime/bin/java"

# Main class to run the app
MAIN_CLASS="de.unijena.bioinf.ms.frontend.SiriusCLIApplication"

# Escape application args
save () {
    for i do printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/" ; done
    echo " "
}
APP_ARGS=`save "$@"`

# Collect all arguments for the java command, following the shell quoting and substitution rules
eval set -- $DEFAULT_JVM_OPTS $JAVA_OPTS $SIRIUS_OPTS -classpath "\"$CLASSPATH\"" "$MAIN_CLASS" "$APP_ARGS"

exec "$JAVACMD" "$@"
