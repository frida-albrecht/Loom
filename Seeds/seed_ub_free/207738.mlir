module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.024000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<-1.156100e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = "tosa.const"() <{values = dense<-165> : tensor<10x7x10x4xi32>}> : () -> tensor<10x7x10x4xi32>
    %3 = "tosa.const"() <{values = dense<116> : tensor<1x1x10x1xi32>}> : () -> tensor<1x1x10x1xi32>
    %4 = tosa.add %0, %1 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %5 = tosa.floor %4 : (tensor<2xf32>) -> tensor<2xf32>
    %6 = tosa.reciprocal %5 : (tensor<2xf32>) -> tensor<2xf32>
    // Undefined Behavior: tosa.pow op requires value1 >= 0 and (value1 > 0 or value2 > 0).
    // %6 (value1) is [-0.00510204, -0.00510204], violating value1 >= 0.
    // %4 (value2) is [-195.85, -195.85].
    // After fixing value1 >= 0 to make it [0.0, 0.0], the condition (0.0 > 0 || -195.85 > 0) is false.
    // Fix: Clamp value1 to be >= 0 and value2 to be >= 1.0 (to ensure value2 > 0 if value1 is 0).
    %b0 = "tosa.const"() <{values = dense<0.0> : tensor<2xf32>}> : () -> tensor<2xf32>
    %b2 = tosa.maximum %6, %b0 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %b1 = "tosa.const"() <{values = dense<1.0> : tensor<2xf32>}> : () -> tensor<2xf32>
    %b3 = tosa.maximum %4, %b1 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %7 = tosa.pow %b2, %b3 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %8 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.tile %7, %8 : (tensor<2xf32>, !tosa.shape<1>) -> tensor<2xf32>
    %10 = tosa.sigmoid %9 : (tensor<2xf32>) -> tensor<2xf32>
    %11 = tosa.bitwise_or %2, %3 : (tensor<10x7x10x4xi32>, tensor<1x1x10x1xi32>) -> tensor<10x7x10x4xi32>
    %12 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %13 = tosa.transpose %11 {perms = array<i32: 0, 3, 1, 2>} : (tensor<10x7x10x4xi32>) -> tensor<10x4x7x10xi32>
    %cast = tensor.cast %10 : tensor<2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %13 : tensor<10x4x7x10xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}