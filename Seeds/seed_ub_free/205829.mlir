module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.677900e+02> : tensor<6x6x6x8xf32>}> : () -> tensor<6x6x6x8xf32>
    %1 = "tosa.const"() <{values = dense<72> : tensor<1x9xi16>}> : () -> tensor<1x9xi16>
    %2 = "tosa.const"() <{values = dense<-164> : tensor<1x9xi16>}> : () -> tensor<1x9xi16>
    %3 = tosa.floor %0 : (tensor<6x6x6x8xf32>) -> tensor<6x6x6x8xf32>
    %4 = tosa.bitwise_or %1, %2 : (tensor<1x9xi16>, tensor<1x9xi16>) -> tensor<1x9xi16>
    %cast = tensor.cast %3 : tensor<6x6x6x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<1x9xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

