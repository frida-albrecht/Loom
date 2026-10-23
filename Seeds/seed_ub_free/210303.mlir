module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.172000e+01> : tensor<7x10x10xf32>}> : () -> tensor<7x10x10xf32>
    %1 = "tosa.const"() <{values = dense<172> : tensor<4x8x8xi16>}> : () -> tensor<4x8x8xi16>
    %2 = tosa.tanh %0 : (tensor<7x10x10xf32>) -> tensor<7x10x10xf32>
    %3 = tosa.clz %1 : (tensor<4x8x8xi16>) -> tensor<4x8x8xi16>
    %cast = tensor.cast %2 : tensor<7x10x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<4x8x8xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

