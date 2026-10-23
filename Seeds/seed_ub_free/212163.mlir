module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<2x4x4x8xi8>}> : () -> tensor<2x4x4x8xi8>
    %1 = "tosa.const"() <{values = dense<-11> : tensor<2x1x1x1xi8>}> : () -> tensor<2x1x1x1xi8>
    %2 = "tosa.const"() <{values = dense<-9.376000e+01> : tensor<8x8x9xf32>}> : () -> tensor<8x8x9xf32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<2x4x4x8xi8>, tensor<2x1x1x1xi8>) -> tensor<2x4x4x8xi8>
    %4 = tosa.ceil %2 : (tensor<8x8x9xf32>) -> tensor<8x8x9xf32>
    %cast = tensor.cast %3 : tensor<2x4x4x8xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %4 : tensor<8x8x9xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

