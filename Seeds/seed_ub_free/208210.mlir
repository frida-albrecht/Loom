module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<7xi8>}> : () -> tensor<7xi8>
    %1 = tosa.identity %0 : (tensor<7xi8>) -> tensor<7xi8>
    %2 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<7xi8>) -> tensor<1xi8>
    %3 = tosa.maximum %2, %2 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %4 = tosa.bitwise_xor %3, %2 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %4 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

