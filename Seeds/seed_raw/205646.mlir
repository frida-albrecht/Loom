module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-149> : tensor<10x3xi32>}> : () -> tensor<10x3xi32>
    %1 = "tosa.const"() <{values = dense<-1.167000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<1.529600e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.clamp %0 {max_val = 30 : i32, min_val = -13 : i32} : (tensor<10x3xi32>) -> tensor<10x3xi32>
    %4 = tosa.maximum %3, %3 : (tensor<10x3xi32>, tensor<10x3xi32>) -> tensor<10x3xi32>
    %5 = tosa.pow %1, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %6 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.tile %4, %6 : (tensor<10x3xi32>, !tosa.shape<2>) -> tensor<20x9xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<20x9xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

