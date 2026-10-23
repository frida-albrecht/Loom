module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<137> : tensor<5x5x5x7xi16>}> : () -> tensor<5x5x5x7xi16>
    %1 = "tosa.const"() <{values = dense<85> : tensor<5x5x5x1xi16>}> : () -> tensor<5x5x5x1xi16>
    %2 = "tosa.const"() <{values = dense<2.481000e+01> : tensor<2x7x1x10xf32>}> : () -> tensor<2x7x1x10xf32>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<5x5x5x7xi16>, tensor<5x5x5x1xi16>) -> tensor<5x5x5x7xi16>
    %4 = tosa.rsqrt %2 : (tensor<2x7x1x10xf32>) -> tensor<2x7x1x10xf32>
    %cast = tensor.cast %3 : tensor<5x5x5x7xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %4 : tensor<2x7x1x10xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

