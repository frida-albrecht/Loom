module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-131> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %1 = "tosa.const"() <{values = dense<64> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %2 = "tosa.const"() <{values = dense<1.240700e+02> : tensor<5x10x6xf32>}> : () -> tensor<5x10x6xf32>
    %3 = "tosa.const"() <{values = dense<2.929000e+01> : tensor<5x1x6xf32>}> : () -> tensor<5x1x6xf32>
    %4 = tosa.logical_left_shift %0, %1 : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %5 = tosa.minimum %2, %3 : (tensor<5x10x6xf32>, tensor<5x1x6xf32>) -> tensor<5x10x6xf32>
    %6 = tosa.arithmetic_right_shift %4, %4 {round = false} : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %5, %7, %8 : (tensor<5x10x6xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<5x10x6xf32>
    %cast = tensor.cast %6 : tensor<6x5x4xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %9 : tensor<5x10x6xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

