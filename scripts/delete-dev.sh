#! /bin/bash
# TODO: get from command arguments
ENV_ID=$1
INSTALL_PATH="$(pwd)/backend.ai-dev"
REMOVE_VENVS="yes"
REMOVE_CONTAINERS="yes"
REMOVE_SOURCE="yes"

if [ "$REMOVE_VENVS" = "yes" ]; then
  echo "Removing Python virtual environments..."
  pyenv uninstall -f "venv-${ENV_ID}-agent"
  pyenv uninstall -f "venv-${ENV_ID}-client"
  pyenv uninstall -f "venv-${ENV_ID}-common"
  pyenv uninstall -f "venv-${ENV_ID}-manager"
else
  echo "Skipped removal of Python virtual environments."
fi

if [ "$REMOVE_CONTAINERS" = "yes" ]; then
  echo "Removing Docker containers..."
  cd "${INSTALL_PATH}/backend.ai"
  docker-compose -p "${ENV_ID}" -f docker-compose.halfstack.yml down
else
  echo "Skipped removal of Docker containers."
fi

if [ "$REMOVE_SOURCE" = "yes" ]; then
  echo "Removing cloned source files..."
  rm -rf "${INSTALL_PATH}"
else
  echo "Skipped removal of cloned source files."
fi
echo "Done."