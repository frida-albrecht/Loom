module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.602000e+01> : tensor<10x9xf32>}> : () -> tensor<10x9xf32>
    %1 = tosa.const_shape  {values = dense<[45, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<10x9xf32>, !tosa.shape<3>) -> tensor<45x1x2xf32>
    %3 = tosa.clamp %2 {max_val = 1.360000e+02 : f32, min_val = -3.400000e+01 : f32} : (tensor<45x1x2xf32>) -> tensor<45x1x2xf32>
    %4 = tosa.reciprocal %3 : (tensor<45x1x2xf32>) -> tensor<45x1x2xf32>
    %5 = tosa.const_shape  {values = dense<[1, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.tile %4, %5 : (tensor<45x1x2xf32>, !tosa.shape<3>) -> tensor<45x2x2xf32>
    %cast = tensor.cast %6 : tensor<45x2x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

