class Openvpn3 < Formula
  desc "C++ OpenVPN client and library"
  homepage "https://github.com/OpenVPN/openvpn3"
  url "https://github.com/OpenVPN/openvpn3/archive/refs/heads/master.tar.gz"
  version "3.10.1"  # Use a version that makes sense
  sha256 :no_check  # GitHub generates different hashes for branch archives
  license "AGPL-3.0-only"
  
  head "https://github.com/OpenVPN/openvpn3.git", branch: "master"

  depends_on "asio"
  depends_on "cmake" => :build
  depends_on "fmt"
  depends_on "jsoncpp"
  depends_on "lz4"
  depends_on "openssl@3"
  depends_on "pkg-config" => :build
  depends_on "xxhash"

  def install
    openssl_root = Formula["openssl@3"].opt_prefix
    
    args = %W[
      -DOPENSSL_ROOT_DIR=#{openssl_root}
      -DCMAKE_PREFIX_PATH=#{HOMEBREW_PREFIX}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    
    bin.install "build/test/ovpncli/ovpncli"
  end

  test do
    system "#{bin}/ovpncli", "--version"
  end
end
