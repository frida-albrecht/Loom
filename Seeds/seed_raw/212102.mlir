module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1> : tensor<7x1xi8>}> : () -> tensor<7x1xi8>
    %1 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 1>} : (tensor<7x1xi8>) -> tensor<7x1xi8>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<7x1xi8>, tensor<7x1xi8>) -> tensor<7x1xi8>
    %cast = tensor.cast %3 : tensor<7x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

