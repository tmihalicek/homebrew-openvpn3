class Openvpn3 < Formula
  desc "C++ OpenVPN client and library"
  homepage "https://github.com/OpenVPN/openvpn3"
  url "https://github.com/OpenVPN/openvpn3/archive/refs/tags/release/3.9.1.tar.gz"
  sha256 "YOUR_SHA256_HERE"  # Get with: shasum -a 256 downloaded_file
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
    # Set OpenSSL path based on architecture
    openssl_root = if Hardware::CPU.arm?
      Formula["openssl@3"].opt_prefix
    else
      Formula["openssl@3"].opt_prefix
    end

    cmake_prefix = if Hardware::CPU.arm?
      HOMEBREW_PREFIX
    else
      HOMEBREW_PREFIX
    end

    system "cmake", "-S", ".", "-B", "build",
                    "-DOPENSSL_ROOT_DIR=#{openssl_root}",
                    "-DCMAKE_PREFIX_PATH=#{cmake_prefix}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    
    # Install the ovpncli binary
    bin.install "build/test/ovpncli/ovpncli"
  end

  test do
    system "#{bin}/ovpncli", "--version"
  end
end
