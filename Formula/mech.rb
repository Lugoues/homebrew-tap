class Mech < Formula
  include Language::Python::Virtualenv

  desc "Easy command line virtual machines for VMWare"
  homepage "https://github.com/mechboxes/mech"
  url "https://github.com/mechboxes/mech/archive/v0.7.0.tar.gz"
  sha256 "6768c1df32c9ef85350b0d855154b02eca8cf9031b88fbdc05b814a591279d62"
  head "https://github.com/mechboxes/mech.git"

  depends_on "python"

  # resource "six" do
  #   url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
  #   sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  # end

  # resource "docopt" do
  #   url "https://files.pythonhosted.org/packages/source/d/docopt/docopt-0.6.2.tar.gz"
  #   sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  # end

  # resource "PyYAML" do
  #   url "https://files.pythonhosted.org/packages/9e/a3/1d13970c3f36777c583f136c136f804d70f500168edc1edea6daa7200769/PyYAML-3.13.tar.gz"
  #   sha256 "3ef3092145e9b70e3ddd2c7ad59bdd0252a94dfe3949721633e41344de00a6bf"
  # end

  # resource "python-dateutil" do
  #   url "https://files.pythonhosted.org/packages/a0/b0/a4e3241d2dee665fea11baec21389aec6886655cd4db7647ddf96c3fad15/python-dateutil-2.7.3.tar.gz"
  #   sha256 "e27001de32f627c22380a688bcc43ce83504a7bc5da472209b4c70f02829f0b8"
  # end

  # resource "pykwalify" do
  #   url "https://files.pythonhosted.org/packages/53/6a/c7394df238816085de6a630f1817805639e844ea7980108f19261cd44c12/pykwalify-1.7.0.tar.gz"
  #   sha256 "7e8b39c5a3a10bc176682b3bd9a7422c39ca247482df198b402e8015defcceb2"
  # end

  # resource "ruamel.yaml" do
  #   url "https://files.pythonhosted.org/packages/88/df/4f095aa617391f789a8df22d3b44fbaf7274dd90dc4982b2fb0637a0fbbc/ruamel.yaml-0.15.92.tar.gz"
  #   sha256 "c6d05e38a141922eca7902135e7a40b605763d6da8ec6624517370631ce9fb6d"
  # end

  # resource "colorama" do
  #   url "https://files.pythonhosted.org/packages/76/53/e785891dce0e2f2b9f4b4ff5bc6062a53332ed28833c7afede841f46a5db/colorama-0.4.1.tar.gz"
  #   sha256 "05eed71e2e327246ad6b38c540c4a3117230b19679b875190486ddd2d721422d"
  # end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz"
    sha256 "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4"
  end

  resource "clint" do
    url "https://files.pythonhosted.org/packages/3d/b4/41ecb1516f1ba728f39ee7062b9dac1352d39823f513bb6f9e8aeb86e26d/clint-0.5.1.tar.gz"
    sha256 "05224c32b1075563d0b16d0015faaf9da43aa214e4a2140e51f08789e7a4c5aa"
  end

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/source/d/docopt/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/14/ec/6ee2168387ce0154632f856d5cc5592328e9cf93127c5c9aeca92c8c16cb/filelock-3.0.12.tar.gz"
    sha256 "18d82244ee114f543149c66a6e0c14e9c4f8a1044b5cdaadd0f82159d6a6ff59"
  end



  def install
    virtualenv_install_with_resources
  end

  # test do
  #   borg = (testpath/"borg")
  #   config_path = testpath/"config.yml"
  #   repo_path = testpath/"repo"
  #   log_path = testpath/"borg.log"

  #   # Create a fake borg executable to log requested commands
  #   borg.write <<~EOS
  #     #!/bin/sh
  #     echo $@ >> #{log_path}

  #     # Return error on info so we force an init to occur
  #     if [ "$1" = "info" ]; then
  #       exit 1
  #     fi
  #   EOS
  #   borg.chmod 0755

  #   # Generate a config
  #   system bin/"generate-borgmatic-config", "--destination", config_path

  #   # Replace defaults values
  #   config_content = File.read(config_path)
  #                        .gsub(/#local_path: borg1/, "local_path: #{borg}")
  #                        .gsub(/user@backupserver:sourcehostname.borg/, repo_path)
  #   File.open(config_path, "w") { |file| file.puts config_content }

  #   # Initialize Repo
  #   system bin/"borgmatic", "-v", "2", "--config", config_path, "--init", "--encryption", "repokey"

  #   # Create a backup
  #   system bin/"borgmatic", "--config", config_path

  #   # See if backup was created
  #   system bin/"borgmatic", "--config", config_path, "--list", "--json"

  #   # Read in stored log
  #   log_content = File.read(log_path)

  #   # Assert that the proper borg commands were executed
  #   assert_equal <<~EOS, log_content
  #     info #{repo_path}
  #     init #{repo_path} --encryption repokey --debug
  #     prune #{repo_path} --keep-daily 7 --prefix {hostname}-
  #     create #{repo_path}::{hostname}-{now:%Y-%m-%dT%H:%M:%S.%f} /home /etc /var/log/syslog*
  #     check #{repo_path} --prefix {hostname}-
  #     list #{repo_path} --json
  #   EOS
  # end
end