module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<60> : tensor<9x9x2xi16>}> : () -> tensor<9x9x2xi16>
    %1 = "tosa.const"() <{values = dense<95.1999969> : tensor<5x6x9xf32>}> : () -> tensor<5x6x9xf32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.negate %0, %2, %3 : (tensor<9x9x2xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<9x9x2xi16>
    %5 = tosa.logical_left_shift %4, %4 : (tensor<9x9x2xi16>, tensor<9x9x2xi16>) -> tensor<9x9x2xi16>
    %6 = tosa.exp %1 : (tensor<5x6x9xf32>) -> tensor<5x6x9xf32>
    %7 = tosa.reciprocal %6 : (tensor<5x6x9xf32>) -> tensor<5x6x9xf32>
    %cast = tensor.cast %5 : tensor<9x9x2xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<5x6x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

