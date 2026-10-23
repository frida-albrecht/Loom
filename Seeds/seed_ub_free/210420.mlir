module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-176> : tensor<1x4x8xi16>}> : () -> tensor<1x4x8xi16>
    %1 = "tosa.const"() <{values = dense<1.279800e+02> : tensor<10x2xf32>}> : () -> tensor<10x2xf32>
    %2 = "tosa.const"() <{values = dense<1.810300e+02> : tensor<10x1xf32>}> : () -> tensor<10x1xf32>
    %3 = "tosa.const"() <{values = dense<-20> : tensor<5xi32>}> : () -> tensor<5xi32>
    %4 = "tosa.const"() <{values = dense<151> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<1x4x8xi16>) -> tensor<1x4x8xi16>
    %6 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<1x4x8xi16>) -> tensor<1x4x1xi16>
    // Undefined Behavior Detected: tosa.minimum operands %1 (tensor<10x2xf32>) and %2 (tensor<10x1xf32>) have different shapes.
    // Hard Constraint 4.1 requires identical rank, shape, and element dtype for tosa.minimum/tosa.maximum operands.
    // Fix: Create a new constant with the value of %2 but with the shape of %1 to satisfy the identical shape requirement.
    %a1 = "tosa.const"() <{values = dense<1.810300e+02> : tensor<10x2xf32>}> : () -> tensor<10x2xf32>
    %7 = tosa.minimum %1, %a1 : (tensor<10x2xf32>, tensor<10x2xf32>) -> tensor<10x2xf32>
    %8 = tosa.clz %6 : (tensor<1x4x1xi16>) -> tensor<1x4x1xi16>
    %9 = tosa.intdiv %3, %4 : (tensor<5xi32>, tensor<1xi32>) -> tensor<5xi32>
    %cast = tensor.cast %7 : tensor<10x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<1x4x1xi16> to tensor<*xi16>
    %cast_1 = tensor.cast %9 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}