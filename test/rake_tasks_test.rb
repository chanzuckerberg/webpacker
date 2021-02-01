require "test_helper"

class RakeTasksTest < Minitest::Test
  def test_rake_tasks
    output = Dir.chdir(test_app_path) { `rake -T` }
    assert_includes output, "webpacker"
    assert_includes output, "webpacker:check_binstubs"
    assert_includes output, "webpacker:check_node"
    assert_includes output, "webpacker:check_npm"
    assert_includes output, "webpacker:clean"
    assert_includes output, "webpacker:clobber"
    assert_includes output, "webpacker:compile"
    assert_includes output, "webpacker:install"
    assert_includes output, "webpacker:install:angular"
    assert_includes output, "webpacker:install:coffee"
    assert_includes output, "webpacker:install:elm"
    assert_includes output, "webpacker:install:erb"
    assert_includes output, "webpacker:install:react"
    assert_includes output, "webpacker:install:svelte"
    assert_includes output, "webpacker:install:stimulus"
    assert_includes output, "webpacker:install:typescript"
    assert_includes output, "webpacker:install:vue"
    assert_includes output, "webpacker:verify_install"
  end

  def test_rake_task_webpacker_check_binstubs
    output = Dir.chdir(test_app_path) { `rake webpacker:check_binstubs 2>&1` }
    refute_includes output, "webpack binstubs not found."
  end

  def test_check_node_version
    output = Dir.chdir(test_app_path) { `rake webpacker:check_node 2>&1` }
    refute_includes output, "Webpacker requires Node.js"
  end

  def test_check_npm_version
    output = Dir.chdir(test_app_path) { `rake webpacker:check_npm 2>&1` }
    refute_includes output, "NPM not installed"
    refute_includes output, "Webpacker requires NPM"
  end

  private
    def test_app_path
      File.expand_path("test_app", __dir__)
    end

    def test_app_dev_dependencies
      package_json = File.expand_path("package.json", test_app_path)
      JSON.parse(File.read(package_json))["devDependencies"]
    end

    def installed_node_module_names
      node_modules_path = File.expand_path("node_modules", test_app_path)
      Dir.chdir(node_modules_path) { Dir.glob("*") }
    end
end
