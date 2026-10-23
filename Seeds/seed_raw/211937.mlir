module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<39> : tensor<10xi16>}> : () -> tensor<10xi16>
    %1 = "tosa.const"() <{values = dense<77> : tensor<1x2xi32>}> : () -> tensor<1x2xi32>
    %2 = "tosa.const"() <{values = dense<8.580000e+01> : tensor<9x6x10xf32>}> : () -> tensor<9x6x10xf32>
    %3 = "tosa.const"() <{values = dense<8.000000e+01> : tensor<1x6x10xf32>}> : () -> tensor<1x6x10xf32>
    %4 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.pad %0, %4, %5 : (tensor<10xi16>, !tosa.shape<2>, tensor<1xi16>) -> tensor<10xi16>
    %7 = tosa.pow %2, %3 : (tensor<9x6x10xf32>, tensor<1x6x10xf32>) -> tensor<9x6x10xf32>
    %8 = tosa.add %7, %7 : (tensor<9x6x10xf32>, tensor<9x6x10xf32>) -> tensor<9x6x10xf32>
    %9 = tosa.pow %8, %7 : (tensor<9x6x10xf32>, tensor<9x6x10xf32>) -> tensor<9x6x10xf32>
    %10 = tosa.minimum %8, %9 : (tensor<9x6x10xf32>, tensor<9x6x10xf32>) -> tensor<9x6x10xf32>
    %cast = tensor.cast %6 : tensor<10xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %10 : tensor<9x6x10xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

