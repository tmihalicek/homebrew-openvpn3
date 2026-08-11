class Openvpn3 < Formula
  desc "C++ OpenVPN client and library"
  homepage "https://github.com/OpenVPN/openvpn3"
  url "https://github.com/OpenVPN/openvpn3/archive/refs/tags/release/3.11.7.tar.gz"
  version "3.11.7"
  sha256 "6ec04d7e7824f043ee2ec6c2d98ce2655350e5cdcc969ab60a5f68cecb232289"
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
    # OpenSSL is located via pkg-config (Homebrew puts keg-only openssl@3 on
    # PKG_CONFIG_PATH), so OPENSSL_ROOT_DIR is not needed here.
    args = %W[
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
