module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<169> : tensor<8x2xi16>}> : () -> tensor<8x2xi16>
    %1 = "tosa.const"() <{values = dense<-80> : tensor<8x1xi16>}> : () -> tensor<8x1xi16>
    %2 = "tosa.const"() <{values = dense<1.543900e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %3 = "tosa.const"() <{values = dense<-1.497400e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %4 = tosa.bitwise_and %0, %1 : (tensor<8x2xi16>, tensor<8x1xi16>) -> tensor<8x2xi16>
    %5 = tosa.pow %2, %3 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %4 : tensor<8x2xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

