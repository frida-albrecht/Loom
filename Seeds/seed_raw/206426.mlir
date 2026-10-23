module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<4x3x4xi8>}> : () -> tensor<4x3x4xi8>
    %1 = "tosa.const"() <{values = dense<12> : tensor<4x1x4xi8>}> : () -> tensor<4x1x4xi8>
    %2 = "tosa.const"() <{values = dense<-7.510000e+01> : tensor<1x6x6xf32>}> : () -> tensor<1x6x6xf32>
    %3 = tosa.sub %0, %1 : (tensor<4x3x4xi8>, tensor<4x1x4xi8>) -> tensor<4x3x4xi8>
    %4 = tosa.reciprocal %2 : (tensor<1x6x6xf32>) -> tensor<1x6x6xf32>
    %cast = tensor.cast %3 : tensor<4x3x4xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %4 : tensor<1x6x6xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

