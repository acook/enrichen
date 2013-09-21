function git_submodule_updateall {

  echo "Updating all git submodules for repository at: $1"
  git_submodule_init_or_update_all $1

}


function git_submodule_initall {

  echo "Initializing and pulling all git submodules for repository at: $1"
  git_submodule_init_or_update_all $1

}


function git_submodule_init_or_update_all {

  path_with_submodules=$1

  # Git needs to be at the root of the parent git repo
  pushd path_with_submodules

  # Safer to reinit every time, in case submodules were added in the meantime
  git submodule update --init --recursive

  # This works around the problem of some repos not using "master" as their primary branch
  git submodule foreach "git fetch -q && git checkout -q origin/HEAD"

  # Clean up after ourselves, make sure we end up back where we started
  popd

}
