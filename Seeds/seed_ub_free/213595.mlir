module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.103400e+02> : tensor<8x8x6x2xf32>}> : () -> tensor<8x8x6x2xf32>
    %1 = "tosa.const"() <{values = dense<-85> : tensor<6x2x6xi16>}> : () -> tensor<6x2x6xi16>
    %2 = tosa.ceil %0 : (tensor<8x8x6x2xf32>) -> tensor<8x8x6x2xf32>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<8x8x6x2xf32>) -> tensor<8x1x6x2xf32>
    %4 = tosa.bitwise_not %1 : (tensor<6x2x6xi16>) -> tensor<6x2x6xi16>
    %5 = tosa.bitwise_not %4 : (tensor<6x2x6xi16>) -> tensor<6x2x6xi16>
    %6 = tosa.identity %4 : (tensor<6x2x6xi16>) -> tensor<6x2x6xi16>
    %cast = tensor.cast %3 : tensor<8x1x6x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6x2x6xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %6 : tensor<6x2x6xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefI16(%cast_1) : (tensor<*xi16>) -> ()
    return
  }
}

