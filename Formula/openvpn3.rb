class Openvpn3 < Formula
  desc "C++ OpenVPN client and library"
  homepage "https://github.com/OpenVPN/openvpn3"
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
    cmake_prefix = HOMEBREW_PREFIX

    system "cmake", "-S", ".", "-B", "build",
                    "-DOPENSSL_ROOT_DIR=#{openssl_root}",
                    "-DCMAKE_PREFIX_PATH=#{cmake_prefix}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    
    bin.install "build/test/ovpncli/ovpncli"
  end

  test do
    system "#{bin}/ovpncli", "--version"
  end
end
