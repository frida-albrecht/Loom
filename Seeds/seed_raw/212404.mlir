module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<7x9x5x1xi8>}> : () -> tensor<7x9x5x1xi8>
    %1 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 3, 1, 2>} : (tensor<7x9x5x1xi8>) -> tensor<7x1x9x5xi8>
    %cast = tensor.cast %2 : tensor<7x1x9x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

