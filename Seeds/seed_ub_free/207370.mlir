module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<1.768800e+02> : tensor<2x1xf32>}> : () -> tensor<2x1xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<1xi8>
    %3 = tosa.log %1 : (tensor<2x1xf32>) -> tensor<2x1xf32>
    %4 = tosa.tanh %3 : (tensor<2x1xf32>) -> tensor<2x1xf32>
    %5 = tosa.bitwise_xor %2, %2 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %4 : tensor<2x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

