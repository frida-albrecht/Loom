module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.737000e+01> : tensor<2x5x1x9xf32>}> : () -> tensor<2x5x1x9xf32>
    %1 = "tosa.const"() <{values = dense<-5.538000e+01> : tensor<1x5x1x1xf32>}> : () -> tensor<1x5x1x1xf32>
    %2 = "tosa.const"() <{values = dense<-6> : tensor<3x10x9xi8>}> : () -> tensor<3x10x9xi8>
    %3 = "tosa.const"() <{values = dense<19> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %4 = tosa.add %0, %1 : (tensor<2x5x1x9xf32>, tensor<1x5x1x1xf32>) -> tensor<2x5x1x9xf32>
    %5 = tosa.bitwise_or %2, %3 : (tensor<3x10x9xi8>, tensor<1x1x1xi8>) -> tensor<3x10x9xi8>
    %cast = tensor.cast %4 : tensor<2x5x1x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<3x10x9xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

