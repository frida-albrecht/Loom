module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.519000e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-177> : tensor<10xi16>}> : () -> tensor<10xi16>
    %2 = "tosa.const"() <{values = dense<70> : tensor<1xi16>}> : () -> tensor<1xi16>
    %3 = tosa.clamp %0 {max_val = 9.700000e+01 : f32, min_val = -9.000000e+00 : f32} : (tensor<f32>) -> tensor<f32>
    %4 = tosa.sigmoid %3 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.logical_right_shift %1, %2 : (tensor<10xi16>, tensor<1xi16>) -> tensor<10xi16>
    %6 = tosa.reciprocal %4 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.log %6 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.reverse %5 {axis = 0 : i32} : (tensor<10xi16>) -> tensor<10xi16>
    %9 = tosa.pow %6, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %10 = tosa.const_shape  {values = dense<7> : tensor<1xindex>} : () -> !tosa.shape<1>
    %11 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %12 = tosa.slice %8, %10, %11 : (tensor<10xi16>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<3xi16>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %12 : tensor<3xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_1) : (tensor<*xi16>) -> ()
    return
  }
}

