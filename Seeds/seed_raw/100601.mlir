module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.075300e+02> : tensor<16x32x64xf32>}> : () -> tensor<16x32x64xf32>
    %1 = "tosa.const"() <{values = dense<-4.440000e+01> : tensor<16x64xf32>}> : () -> tensor<16x64xf32>
    %2 = "tosa.const"() <{values = dense<-130> : tensor<16x32x64xi64>}> : () -> tensor<16x32x64xi64>
    %3 = "tosa.const"() <{values = dense<112> : tensor<16x64xi64>}> : () -> tensor<16x64xi64>
    %reduced:2 = linalg.reduce ins(%0, %2 : tensor<16x32x64xf32>, tensor<16x32x64xi64>) outs(%1, %3 : tensor<16x64xf32>, tensor<16x64xi64>) dimensions = [1] 
      (%in: f32, %in_1: i64, %init: f32, %init_2: i64) {
        %4 = arith.addf %in, %init : f32
        %5 = arith.addi %in_1, %init_2 : i64
        linalg.yield %4, %5 : f32, i64
      }
    %cast = tensor.cast %reduced#0 : tensor<16x64xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %reduced#1 : tensor<16x64xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

