crb() {
  if [[ -f ".ruby-version" ]]; then
    ruby_version=$(cat .ruby-version)
    if ! asdf where ruby $ruby_version; then
      asdf install ruby $ruby_version
    fi
    asdf shell ruby $ruby_version
  else
    echo "No .ruby-version file found"
  fi
}
