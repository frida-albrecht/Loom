module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<3x1x8x1xi8>}> : () -> tensor<3x1x8x1xi8>
    %1 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<3x1x8x1xi8>) -> tensor<3x1x8x1xi8>
    %2 = tosa.bitwise_and %1, %1 : (tensor<3x1x8x1xi8>, tensor<3x1x8x1xi8>) -> tensor<3x1x8x1xi8>
    %cast = tensor.cast %2 : tensor<3x1x8x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

