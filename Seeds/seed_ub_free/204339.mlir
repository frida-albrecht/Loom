module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-59> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-9.590000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-2.753000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.sub %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.abs %4 : (tensor<i32>) -> tensor<i32>
    // UB detected: tosa.logical_right_shift input %4 (value2) is 50, but must be in [0, 31] for i32.
    // Fixing by clamping %4 to [0, 31].
    %c1 = "tosa.const"() <{values = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<i32>}> : () -> tensor<i32>
    %t1 = tosa.maximum %4, %c1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %t2 = tosa.minimum %t1, %c2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.logical_right_shift %5, %t2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    // UB detected: tosa.pow input %2 (value1) is -95.9, which violates value1 >= 0.
    // Fixing by clamping %2 to max(value1, 0.0).
    %c3 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %t3 = tosa.maximum %2, %c3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    // After previous fix, value1 (now %t3) is 0.0. Input %3 (value2) is -27.53.
    // This violates value1 > 0 || value2 > 0 (0.0 > 0 || -27.53 > 0 is false).
    // Fixing by clamping %3 to max(value2, 1.0) since value1 is 0.0.
    %c4 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %t4 = tosa.maximum %3, %c4 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %7 = tosa.pow %t3, %t4 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    // UB detected: tosa.logical_left_shift input %5 (value2) is 50, but must be in [0, 31] for i32.
    // Fixing by clamping %5 to [0, 31]. Constants %c1 (0) and %c2 (31) are reused.
    %t5 = tosa.maximum %5, %c1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %t6 = tosa.minimum %t5, %c2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %8 = tosa.logical_left_shift %6, %t6 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}