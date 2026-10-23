module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<118> : tensor<9xi16>}> : () -> tensor<9xi16>
    %1 = "tosa.const"() <{values = dense<36> : tensor<1xi16>}> : () -> tensor<1xi16>
    %2 = "tosa.const"() <{values = dense<-1.488500e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<9xi16>, tensor<1xi16>) -> tensor<9xi16>
    %4 = tosa.concat %3, %3 {axis = 0 : i32} : (tensor<9xi16>, tensor<9xi16>) -> tensor<18xi16>
    %5 = tosa.const_shape  {values = dense<[9, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.reshape %4, %5 : (tensor<18xi16>, !tosa.shape<3>) -> tensor<9x2x1xi16>
    %7 = tosa.concat %6, %6 {axis = 0 : i32} : (tensor<9x2x1xi16>, tensor<9x2x1xi16>) -> tensor<18x2x1xi16>
    %8 = tosa.reciprocal %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %7 : tensor<18x2x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

