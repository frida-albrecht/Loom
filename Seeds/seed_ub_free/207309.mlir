module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<8x9x3xi8>}> : () -> tensor<8x9x3xi8>
    %1 = "tosa.const"() <{values = dense<-9> : tensor<1x1x3xi8>}> : () -> tensor<1x1x3xi8>
    %2 = "tosa.const"() <{values = dense<1.928400e+02> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<8x9x3xi8>, tensor<1x1x3xi8>) -> tensor<8x9x3xi8>
    %4 = tosa.sub %3, %3 : (tensor<8x9x3xi8>, tensor<8x9x3xi8>) -> tensor<8x9x3xi8>
    %5 = tosa.rsqrt %2 : (tensor<3x4xf32>) -> tensor<3x4xf32>
    %cast = tensor.cast %4 : tensor<8x9x3xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<3x4xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

