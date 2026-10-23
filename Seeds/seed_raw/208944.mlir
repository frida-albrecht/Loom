module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.839800e+02> : tensor<4x6x2xf32>}> : () -> tensor<4x6x2xf32>
    %1 = "tosa.const"() <{values = dense<1.167900e+02> : tensor<1x6x1xf32>}> : () -> tensor<1x6x1xf32>
    %2 = "tosa.const"() <{values = dense<91> : tensor<10x5x6x8xi16>}> : () -> tensor<10x5x6x8xi16>
    %3 = tosa.add %0, %1 : (tensor<4x6x2xf32>, tensor<1x6x1xf32>) -> tensor<4x6x2xf32>
    %4 = tosa.bitwise_not %2 : (tensor<10x5x6x8xi16>) -> tensor<10x5x6x8xi16>
    %5 = tosa.minimum %3, %3 : (tensor<4x6x2xf32>, tensor<4x6x2xf32>) -> tensor<4x6x2xf32>
    %6 = tosa.bitwise_and %4, %4 : (tensor<10x5x6x8xi16>, tensor<10x5x6x8xi16>) -> tensor<10x5x6x8xi16>
    %cast = tensor.cast %5 : tensor<4x6x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<10x5x6x8xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

