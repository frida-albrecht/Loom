module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<9xi8>}> : () -> tensor<9xi8>
    %1 = "tosa.const"() <{values = dense<-1.281500e+02> : tensor<10x5xf32>}> : () -> tensor<10x5xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<9xi8>) -> tensor<i32>
    %3 = tosa.floor %1 : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %4 = tosa.sigmoid %3 : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %5 = tosa.tanh %4 : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %6 = tosa.logical_left_shift %2, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %7 = tosa.reduce_min %5 {axis = 0 : i32} : (tensor<10x5xf32>) -> tensor<1x5xf32>
    %8 = tosa.clamp %3 {max_val = 3.600000e+01 : f32, min_val = -2.700000e+01 : f32} : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %9 = tosa.rsqrt %8 : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %cast = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<1x5xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %9 : tensor<10x5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

