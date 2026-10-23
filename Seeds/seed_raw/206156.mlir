module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.610000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<8> : tensor<10x1x7xi8>}> : () -> tensor<10x1x7xi8>
    %2 = "tosa.const"() <{values = dense<-2> : tensor<1x1x7xi8>}> : () -> tensor<1x1x7xi8>
    %3 = tosa.reciprocal %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.rsqrt %3 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.bitwise_xor %1, %2 : (tensor<10x1x7xi8>, tensor<1x1x7xi8>) -> tensor<10x1x7xi8>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<10x1x7xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

