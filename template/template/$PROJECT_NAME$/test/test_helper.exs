Code.put_compiler_option(:warnings_as_errors, true)

ExUnit.start(capture_log: true)
ExUnit.configure(exclude: :release_version)

