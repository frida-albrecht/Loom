module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.245000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<192> : tensor<3x7x10xi16>}> : () -> tensor<3x7x10xi16>
    %2 = "tosa.const"() <{values = dense<-61> : tensor<1x7x10xi16>}> : () -> tensor<1x7x10xi16>
    %3 = tosa.tanh %0 : (tensor<2xf32>) -> tensor<2xf32>
    %4 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<2xf32>, !tosa.shape<1>) -> tensor<6xf32>
    %6 = tosa.bitwise_and %1, %2 : (tensor<3x7x10xi16>, tensor<1x7x10xi16>) -> tensor<3x7x10xi16>
    %7 = tosa.sub %5, %5 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %8 = tosa.add %7, %7 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %9 = tosa.reciprocal %8 : (tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %6 : tensor<3x7x10xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %9 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

