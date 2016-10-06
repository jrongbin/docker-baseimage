if [ "$DOCKER_ENV" != development ]; then
  return
fi

SSH_ENV=$HOME/.ssh/environment
function start_agent {
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
     . ${SSH_ENV} > /dev/null
     /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -efp ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent
     }
else
     start_agent
fi
