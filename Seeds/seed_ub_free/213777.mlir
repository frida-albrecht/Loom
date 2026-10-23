module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-131> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %1 = "tosa.const"() <{values = dense<64> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %2 = "tosa.const"() <{values = dense<1.240700e+02> : tensor<5x10x6xf32>}> : () -> tensor<5x10x6xf32>
    %3 = "tosa.const"() <{values = dense<2.929000e+01> : tensor<5x1x6xf32>}> : () -> tensor<5x1x6xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %tmp0 = tosa.maximum %1, %c0 : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %tmp1 = tosa.minimum %tmp0, %c1 : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %4 = tosa.logical_left_shift %0, %tmp1 : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %tmp2 = "tosa.const"() <{values = dense<2.929000e+01> : tensor<5x10x6xf32>}> : () -> tensor<5x10x6xf32>
    %5 = tosa.minimum %2, %tmp2 : (tensor<5x10x6xf32>, tensor<5x10x6xf32>) -> tensor<5x10x6xf32>
    %c2 = "tosa.const"() <{values = dense<0> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %c3 = "tosa.const"() <{values = dense<15> : tensor<6x5x4xi16>}> : () -> tensor<6x5x4xi16>
    %tmp3 = tosa.maximum %4, %c2 : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %tmp4 = tosa.minimum %tmp3, %c3 : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
    %6 = tosa.arithmetic_right_shift %4, %tmp4 {round = false} : (tensor<6x5x4xi16>, tensor<6x5x4xi16>) -> tensor<6x5x4xi16>
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