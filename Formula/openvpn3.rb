class Openvpn3 < Formula
  desc "C++ OpenVPN client and library"
  homepage "https://github.com/OpenVPN/openvpn3"
  url "https://github.com/OpenVPN/openvpn3/archive/refs/tags/release/3.11.6.tar.gz"
  version "3.11.6"
  sha256 "b53dcecb0931b517ab8f5045435aa4000c597b35fb129e4162e7b25ebc99f6cf"
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
