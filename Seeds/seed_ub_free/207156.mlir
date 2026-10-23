module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-36> : tensor<5x6xi16>}> : () -> tensor<5x6xi16>
    %1 = "tosa.const"() <{values = dense<-1.264800e+02> : tensor<6x2xf32>}> : () -> tensor<6x2xf32>
    %2 = tosa.bitwise_not %0 : (tensor<5x6xi16>) -> tensor<5x6xi16>
    %3 = tosa.reciprocal %1 : (tensor<6x2xf32>) -> tensor<6x2xf32>
    %4 = tosa.bitwise_xor %2, %2 : (tensor<5x6xi16>, tensor<5x6xi16>) -> tensor<5x6xi16>
    %cast = tensor.cast %3 : tensor<6x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<5x6xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

