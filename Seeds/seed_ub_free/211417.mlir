module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<6x8x8xi16>}> : () -> tensor<6x8x8xi16>
    %1 = "tosa.const"() <{values = dense<1.961400e+02> : tensor<9x3x1x9xf32>}> : () -> tensor<9x3x1x9xf32>
    %2 = tosa.clamp %0 {max_val = 148 : i16, min_val = 46 : i16} : (tensor<6x8x8xi16>) -> tensor<6x8x8xi16>
    %3 = tosa.tanh %1 : (tensor<9x3x1x9xf32>) -> tensor<9x3x1x9xf32>
    %cast = tensor.cast %2 : tensor<6x8x8xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %3 : tensor<9x3x1x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

