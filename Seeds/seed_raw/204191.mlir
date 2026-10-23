module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-60> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-34> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<4.281000e+01> : tensor<8x9xf32>}> : () -> tensor<8x9xf32>
    %3 = "tosa.const"() <{values = dense<-1.345100e+02> : tensor<1x9xf32>}> : () -> tensor<1x9xf32>
    %4 = tosa.add %0, %1 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %5 = tosa.minimum %2, %3 : (tensor<8x9xf32>, tensor<1x9xf32>) -> tensor<8x9xf32>
    %cast = tensor.cast %4 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<8x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

