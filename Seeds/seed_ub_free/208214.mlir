module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<4x1x8x1xi16>}> : () -> tensor<4x1x8x1xi16>
    %1 = "tosa.const"() <{values = dense<-176> : tensor<1x1x1x1xi16>}> : () -> tensor<1x1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<-1.131800e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<4x1x8x1xi16>, tensor<1x1x1x1xi16>) -> tensor<4x1x8x1xi16>
    %4 = tosa.bitwise_or %3, %3 : (tensor<4x1x8x1xi16>, tensor<4x1x8x1xi16>) -> tensor<4x1x8x1xi16>
    %5 = tosa.exp %2 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.identity %5 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.concat %4, %3 {axis = 0 : i32} : (tensor<4x1x8x1xi16>, tensor<4x1x8x1xi16>) -> tensor<8x1x8x1xi16>
    %cast = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<8x1x8x1xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

